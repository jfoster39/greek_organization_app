# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

billhighway = FinancialProvider.create(name: "Billhighway", external_url: "http://billhighway.com")
beta = Organization.create(name: "Beta Theta Pi", financial_provider: billhighway)

tripp = User.create(
  email: "tripp.roberts@gtbeta.org",
  password: "password",
  password_confirmation: "password",
  phone_number: "4048892964",
  first_name: "Tripp",
  last_name: "Roberts",
  organization: beta,
  role: "admin"
)

mick = User.create(
  email: "mick.stapleton@gtbeta.org",
  password: "password",
  password_confirmation: "password",
  phone_number: "4048892964",
  first_name: "Mick",
  last_name: "Stapleton",
  organization: beta,
  role: "admin"
)

kenta = User.create(
  email: "kenta.yasuda@gtbeta.org",
  password: "password",
  password_confirmation: "password",
  phone_number: "4048892964",
  first_name: "Kenta",
  last_name: "Yasuda",
  organization: beta,
  role: "admin"
)

User.create(
  email: "chase.reineke@gtbeta.org",
  password: "password",
  password_confirmation: "password",
  phone_number: "4048892964",
  first_name: "Chase",
  last_name: "Reineke",
  organization: beta,
  role: "member"
)

User.create(
  email: "patrick.guiney@gtbeta.org",
  password: "password",
  password_confirmation: "password",
  phone_number: "4048892964",
  first_name: "Patrick",
  last_name: "Guiney",
  organization: beta,
  role: "member"
)

User.create(
  email: "hunter.tuck@gtbeta.org",
  password: "password",
  password_confirmation: "password",
  phone_number: "4048892964",
  first_name: "Hunter",
  last_name: "Tuck",
  organization: beta,
  role: "pending"
)

User.create(
  email: "anthony.ferrari@gtbeta.org",
  password: "password",
  password_confirmation: "password",
  phone_number: "4048892964",
  first_name: "Anthony",
  last_name: "Ferrari",
  organization: beta,
  role: "pending"
)

Announcement.create(
  user: tripp,
  organization: beta,
  title: "Sports",
  plaintext_body: "Fellas,
  Our first A-team flag football game is tonight against lambda chi at 10. It would be awesome if we could get a huge showing out there for the game. There is also softball practice tonight so a lot of you should already be up there. Invite gals and guys and show us some love. I know no one has tests this week so there isn't a reason to miss Natty Ice  throwing bombs to Tripp and Scott and I, along with Pat and Noland locking down the D block. 
  Also if you are trying to play B team it's a good time to see what 4v4 looks like if you haven't before.",
  html_body: "<p>Fellas,</p><br/>" +
  "<p>Our first A-team flag football game is tonight against lambda chi at 10. It would be awesome if we could get a huge showing out there for the game. There is also softball practice tonight so a lot of you should already be up there. Invite gals and guys and show us some love. I know no one has tests this week so there isn't a reason to miss Natty Ice  throwing bombs to Tripp and Scott and I, along with Pat and Noland locking down the D block. </p>" +
  "<p>Also if you are trying to play B team it's a good time to see what 4v4 looks like if you haven't before.</p>"
)

Announcement.create(
  user: mick,
  organization: beta,
  title: "Summer Housing Contract",
  plaintext_body: "Dudes,
    Attached are the contracts. I need each of you to print a copy, sign it, and bring it to me by Monday, April 6th. Due with the contract is a $500 deposit, $250 of which is refundable at the end of summer, or will become part of  the $500 deposit for your fall/spring semester. The remaining balance of $550 is due upon move in. You will not receive a key until you have paid in full. This is all outlined in the contract.
    Yes, your deposits roll over if you currently live in the house. I know you have $500 down instead of $250 but it complicates things to change it b/c most of you will be here in the fall and it would change back.  Upon move in I will need your check of $800.
    If you have any questions just ask.
    Hope to see you all at the game today.
    YFNHM",
  html_body: "<p>Dudes</p><br/>" +
  "<p>Attached are the contracts. I need each of you to print a copy, sign it, and bring it to me by Monday, April 6th. Due with the contract is a $500 deposit, $250 of which is refundable at the end of summer, or will become part of  the $500 deposit for your fall/spring semester. The remaining balance of $550 is due upon move in. You will not receive a key until you have paid in full. This is all outlined in the contract.</p>" +
  "<p>Yes, your deposits roll over if you currently live in the house. I know you have $500 down instead of $250 but it complicates things to change it b/c most of you will be here in the fall and it would change back.  Upon move in I will need your check of $800.</p>" +
  "<p>If you have any questions just ask.</p>" +
  "<p>Hope to see you all at the game today.</p>" +
  "<br/>" +
  "<p>YFNHM</p>"
)

Announcement.create(
  user: kenta,
  organization: beta,
  title: "Thursday Date Night",
  plaintext_body: "Hello all,

  Here are the specs for the date night this Thursday:

  Theme: Hawaiian Shirts & Luau Skirts
  Venue: Hangovers Buckhead
  Bus Departures Times From Beta: 9:30 PM; 10:10 PM
  Bus Departures Times From Hangovers: 12:30 AM; 1:10 AM
  Bar: Cash Bar

  Thanks,
  Kenta Yasuda -2036-",
  html_body: "<p>Hello all,</p><br/>" +
  "<p>Here are the specs for the date night this Thursday:</p>" +
  "<p><b>Theme:</b> Hawaiian Shirts & Luau Skirts</p>" +
  "<p><b>Venue:</b> Hangovers Buckhead</p>" +
  "<p><b>Bus Departures Times From Beta:</b> 9:30 PM; 10:10 PM</p>" +
  "<p><b>Bus Departures Times From Hangovers:</b> 12:30 AM; 1:10 AM</p>" +
  "<p><b>Bar:</b> Cash Bar</p>" +
  "<br/>" +
  "<p>Thanks,</p>" +
  "<p>Kenta Yasuda -2036-</p>"
)
