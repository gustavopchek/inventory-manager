# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

STORE_NAMES = [
  'ALDO Centre Eaton',
  'ALDO Destiny USA Mall',
  'ALDO Pheasant Lane Mall',
  'ALDO Holyoke Mall',
  'ALDO Maine Mall',
  'ALDO Crossgates Mall',
  'ALDO Burlington Mall',
  'ALDO Solomon Pond Mall',
  'ALDO Auburn Mall',
  'ALDO Waterloo Premium Outlets'
]

PRODUCT_MODELS = [
  'ADERI',
  'MIRIRA',
  'CAELAN',
  'BUTAUD',
  'SCHOOLER',
  'SODANO',
  'MCTYRE',
  'CADAUDIA',
  'RASIEN',
  'WUMA',
  'GRELIDIEN',
  'CADEVEN',
  'SEVIDE',
  'ELOILLAN',
  'BEODA',
  'VENDOGNUS',
  'ABOEN',
  'ALALIWEN',
  'GREG',
  'BOZZA'
]

STORE_NAMES.each do |store_name|
  Store.create!(name: store_name, uid: store_name.underscore.gsub(" ", "_"))
end

PRODUCT_MODELS.each do |model_name|
  Product.create!(name: model_name, uid: model_name.underscore.gsub(" ", "_"))
end
