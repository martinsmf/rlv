Then('i am redirected to the Dashboard') do
    expect(@dash_page.on_dash?).to be true 
end

Then('i see the message {string}') do |expect_alert|
    expect(@alert.alert_darck).to eql expect_alert
end

Then('must contain the message {string}') do |expect_alert|
    expect(@alert.alert_darck).to have_text expect_alert
end