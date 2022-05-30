p "Started seeding the tables..."

# TODO: Use something e.g. find or initialize by
# TODO: Requirement to clear: Either we need to filter out invalid emails or adjust regex validation to support dataset emails
File.open('./db/seeds/merchants.csv').each_line do |line|
  merchant = line.strip.split(',')

  Merchant.create(id: merchant[0], name: merchant[1], email: merchant[2], cif: merchant[3])
end
p 'Merchants Seeded'


File.foreach('./db/seeds/shoppers.csv') do |row|
  shopper = row.strip.split(',')

  Shopper.create(id: shopper[0], name: shopper[1], email: shopper[2], nif: shopper[3])
end
p 'Shoppers Seeded'


File.foreach('./db/seeds/orders.csv') do |row|
  order = row.strip.split(',')

  Order.create(
    id: order[0],
    merchant_id: order[1],
    shopper_id: order[2],
    amount: order[3].to_f,
    created_at: DateTime.parse(order[4]),
    completed_at: order[5] && DateTime.parse(order[5])
  )
end
p 'Orders Seeded'

p 'hurryyyy! Seeds completed successfully!'