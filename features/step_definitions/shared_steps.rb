Then('i am redirected to the Dashboard') do
    expect(page).to have_css ".dashboard"
end