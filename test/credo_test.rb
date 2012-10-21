require 'test/unit'
require 'credo'

class CredoTest < Test::Unit::TestCase
  def test_use
    credentials = Credo.new(username: 'user', password: 'pass')
    exported_username = nil
    exported_password = nil

    credentials.use do |username, password|
      exported_username = username
      exported_password = password
    end

    assert_equal exported_username, 'user'
    assert_equal exported_password, 'pass'
  end
  
  def test_missing_password
    credentials = Credo.new(username: 'user')
    exported_password = ""
    
    credentials.use do |username, password|
      exported_password = password
    end
    
    assert_nil exported_password
  end
  
  def test_key_is_random
    creds1 = Credo.new(username: 'user', password: 'pass')
    creds2 = Credo.new(username: 'user', password: 'pass')
    
    refute_equal creds1.instance_variable_get(:@key),
                 creds2.instance_variable_get(:@key)
  end
  
  def test_prompt_mechanism
    credentials = Credo.new(username: 'user', prompt: :test)
    exported_password = nil
  
    credentials.use do |username, password|
      exported_password = password
    end
  
    assert_equal exported_password, 'test'
  end
end
