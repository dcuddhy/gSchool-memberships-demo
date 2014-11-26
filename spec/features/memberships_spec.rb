require 'rails_helper'

feature "Memberships" do

  scenario "User adds a member to a project" do
    project = create_project(name: "Acme")
    create_user(first_name: "Ed", last_name: "Smith")

    visit project_path(project)
    click_on "0 Members"

    within(".memberships") do
      expect(page).to have_no_content("Ed Smith")
      expect(page).to have_no_content("Member")
    end

    select "Ed Smith", from: "membership_user_id"
    click_on "Add New Member"

    expect(page).to have_content("Ed Smith was added successfully")
    within(".memberships") do
      expect(page).to have_content("Ed Smith")
      expect(page).to have_content("Member")
    end
  end

  scenario "user tries to create a membership without a user" do
    project = create_project(name: "Acme")
    create_user(first_name: "Ed", last_name: "Smith")
    firsties = create_user(first_name: "Firsties", last_name: "Smith")
    membership = create_membership(project: project, user: firsties, role: "Owner")

    visit project_path(project)
    click_on "1 Member"

    within(".memberships") do
      expect(page).to have_content("Firsties")
      expect(page).to have_content("Owner")
    end

    click_on "Add New Member"

    expect(page).to have_content("1 error prohibited this membership from being saved")
    expect(page).to have_content("User can't be blank")

    within(".memberships") do
      expect(page).to have_content("Firsties")
      expect(page).to have_content("Owner")
      expect(page).to have_no_content("Member")
    end


  end

end
