
# Companies
if !(Company.count > 0)
  Company.create(name: "Company ABC");
  Company.create(name: "Company XYZ");
else
  puts "Companies table is not Empty, skipping seed data"
end

# Clients
if !(Client.count > 0)
  Client.create(name: "Client DE", company_id: Company.find_by(name: 'Company ABC').id);
  Client.create(name: "Client PQ", company_id: Company.find_by(name: 'Company ABC').id);
else
  puts "Clients table is not Empty, skipping seed data"
end

# Projects
if !(Project.count > 0)
  Project.create(name: "Project A1", client_id: Client.find_by(name: 'Client DE').id);
  Project.create(name: "Project B2", client_id: Client.find_by(name: 'Client DE').id);
else
  puts "Projects table is not Empty, skipping seed data"
end

# Employee seed data
if !(Employee.count > 0)
  Employee.create(name: "Employee E1", company_id: Company.find_by(name: 'Company ABC').id);
  Employee.create(name: "Employee E2", company_id: Company.find_by(name: 'Company ABC').id);
else
  puts "Employees table is not Empty, skipping seed data"
end 

# # Works
# # Employee seed data
# if !(Work.count > 0)
#   Work.create(name: "Employee E1", client_id: Client.find_by(name: 'Client DE'));
#   Work.create(name: "Employee E2");
# else
#   puts "Employees table is not Empty, skipping seed data"
