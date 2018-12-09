require 'calabash-android/calabash_steps'

Then /^I hide the keyboard$/ do
    # query "textField isFirstResponder:1", :resignFirstResponder
    hide_soft_keyboard()
end