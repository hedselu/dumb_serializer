# dumbdump

This gem is mongoDB mapper that allows you to save, destroy and load any custom object with deep nested core/custom attributes.

At actual version the only restriction is, that objects you want to save/load, cannot have initializers with arguments-passing or they provide optional params values if nothing is passed(nil, hash, etc.).

Below are few examples of using gem.

```ruby
class CoolClass
  attr_accessor :cool_attr
  include DumbSerializer

  def initialize
    @cool_attr = NestedClass.new
  end
end

class NestedClass
  attr_accessor :nested_attr

  def initialize
    @nested_attr = 9
  end
end
```

## serialization
You would usually use document id to find it, but in any case, insertion result is being returned from `#serialize`.

```ruby
object = CoolClass.new
id = object.dump.inserted_id.to_s #=> '562f8ab72d27c231fb000003'
```
## loading

```ruby
CoolClass.find(id) #=> <CoolClass:0x000000016ad438 @cool_attr = <NestedClass:0x000000016ad439
                  # @nested_attr = 9>,  @config_attr={:cool_attr=>0}>
CoolClass.all     #=> array of saved objects
```

## destroying
`.drop` method drops collection belonging to class.
```ruby
CoolClass.remove(id)
CoolClass.drop
```
## config
You can configure database connection with `.db_config=` by passing options like `database`, `host`, `port`.
**Beware of configuration. If you set it up for one class it will influence setup of other classes that include `DumpSerializer`**.
```ruby
# These are defaults
CoolClass.db_config #=> { database: 'dumb_serializer', host: '127.0.0.1', port: '27017'}
CoolClass.db_config = { database: 'custom' }
CoolClass.db_config #=> { database: 'custom', host: '127.0.0.1', port: '27017'}              
```





<p align='center' >
 <img src="http://ruby.zigzo.com/wp-content/uploads/sites/2/2013/01/spike_and_rarity__s_heart_shaped_fire_ruby_by_edwardten.png" alt="Ruby beauty" height="100" width="100">
</p>
