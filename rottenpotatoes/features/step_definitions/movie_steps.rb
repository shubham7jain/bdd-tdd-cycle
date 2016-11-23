# Add a declarative step here for populating the DB with movies.

Given /^the following movies exist:$/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
    
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  end
end


Then /^the director of "([^"]*)" should be "([^"]*)"$/ do |arg1, arg2|
   assert page.body =~ /#{arg1}.+Director.+#{arg2}/m
   # express the regexp above with the code you wish you had
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  assert page.body =~ /#{e1}.+#{e2}/m
end

# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  if uncheck == "un"
    rating_list.split(', ').each {|x| step %{I uncheck "ratings_#{x}"}}
  else
    rating_list.split(', ').each {|x| step %{I check "ratings_#{x}"}}
  end
end

Then /I should not see any of the movies/ do
  rows = page.all('#movies tr').size - 1
  assert rows == 0
end

Then /I should see all of the movies/ do
  rows = page.all('#movies tr').size - 1
  assert rows == Movie.count()
end