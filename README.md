# Novicap Challange

### System Requirements
- ruby 2.5.3

#### Usage
To run the application:
```
    $ bundle install
    $ ruby start.rb
```
This will open an IRB console, where you can execute the ruby statements
For example:
```
    $ ruby start.rb
```
you will see and output like this on screen:
```
  2.5.3 :001 >
```
now enter the inputs like following:
```
co = Checkout.new(pricing_rules)
co.scan("VOUCHER")
co.scan("VOUCHER")
co.scan("TSHIRT")
price = co.total
#
```
Output will be :
```
  Total: 25€
```

#### Specs
To run the Specs
```
  $ rspec spec
```
The products are flexible and are loaded through products.json file from the root directory of the project.
You can add or modify this JSON file according to your needs.
