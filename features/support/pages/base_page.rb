# frozen_string_literal: true

# Shared behavior for pages under test
class BasePage
  # Use JavaScript native input to fill input type elements
  # Avoids issues with Watir's input fill missing characters
  # Also bubble up the input event in the DOM for frameworks
  # that spy on inputs (causing missing characters)
  JAVASCRIPT_NATIVE_INPUT_VALUE_SCRIPT = <<~JS
    const el = arguments[0];
    const val = arguments[1];
    const nativeInputValueSetter = Object.getOwnPropertyDescriptor(
      window.HTMLInputElement.prototype, 'value'
    ).set;
    nativeInputValueSetter.call(el, val);
    el.dispatchEvent(new Event('input', { bubbles: true }));
    el.dispatchEvent(new Event('change', { bubbles: true }));
  JS

  attr_reader :browser, :page_url

  def initialize(browser, page_url:, timeout: Watir.default_timeout)
    @browser = browser
    @page_url = page_url
    @timeout = timeout
  end

  def visit!
    browser.goto(page_url)
    on_page!
  end

  def on_page!(timeout: @timeout, &readiness)
    tap do
      on_page_url!(timeout:)

      element = readiness ? readiness.call(self) : page_ready_element
      wait_until_present(element, timeout:)
    end
  end

  def on_page_url!(expected: true, timeout: @timeout)
    Watir::Wait.until(timeout:) { (browser.url == page_url) == expected }
  end

  protected

  def page_ready_element
    raise NotImplementedError, "#{self.class} must define a page readiness element"
  end

  def wait_until_present(element, timeout: @timeout)
    element.wait_until(timeout:, &:present?)
  end

  def fill_input(value, timeout: @timeout, **locator)
    field = browser.text_field(**locator).wait_until(timeout:, &:present?)
    browser.execute_script(JAVASCRIPT_NATIVE_INPUT_VALUE_SCRIPT, field, value.to_s)
  end
end
