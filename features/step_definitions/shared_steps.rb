Then('i am redirected to the Dashboard') do
    expect(page).to have_css ".dashboard"
end

Then('i see the message {string}') do |expect_alert|
    alert = find(".alert-dark")
    expect(alert.text).to eql expect_alert  
end