require 'rails_helper'

describe "Sign in flow" do
  
  describe "successful" do
    it "redirects to the topics index" do
      user = create(:user)
      visit root_path

      click_link 'Sign In'
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password

      within 'form' do
        click_button 'Sign in'

      expect(current_path).to eq topics_path
      end
    end
  end
end