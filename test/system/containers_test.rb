require "application_system_test_case"

class ContainersTest < ApplicationSystemTestCase
  setup do
    @container = containers(:one)
  end

  test "visiting the index" do
    visit containers_url
    assert_selector "h1", text: "Containers"
  end

  test "should create container" do
    visit containers_url
    click_on "New container"

    fill_in "Addon json", with: @container.addon_json
    fill_in "Container", with: @container.container_id
    fill_in "Last used", with: @container.last_used
    fill_in "Name", with: @container.name
    fill_in "Open ports", with: @container.open_ports
    fill_in "Os name", with: @container.os_name
    fill_in "Status", with: @container.status
    fill_in "Storag used", with: @container.storag_used
    fill_in "Usage limit json", with: @container.usage_limit_json
    click_on "Create Container"

    assert_text "Container was successfully created"
    click_on "Back"
  end

  test "should update Container" do
    visit container_url(@container)
    click_on "Edit this container", match: :first

    fill_in "Addon json", with: @container.addon_json
    fill_in "Container", with: @container.container_id
    fill_in "Last used", with: @container.last_used.to_s
    fill_in "Name", with: @container.name
    fill_in "Open ports", with: @container.open_ports
    fill_in "Os name", with: @container.os_name
    fill_in "Status", with: @container.status
    fill_in "Storag used", with: @container.storag_used
    fill_in "Usage limit json", with: @container.usage_limit_json
    click_on "Update Container"

    assert_text "Container was successfully updated"
    click_on "Back"
  end

  test "should destroy Container" do
    visit container_url(@container)
    click_on "Destroy this container", match: :first

    assert_text "Container was successfully destroyed"
  end
end
