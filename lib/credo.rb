require 'encryptor'
require 'highline/import'

class Credo
  def initialize(params)
    @params = params

    @username = @params[:username]
    password = @params.delete(:password)

    password ||= case params[:prompt]
      when :console
        ask("Enter password: ") { |q| q.echo = false }
      when :test
        'test'
    end
    
    make_key
    password_encrypt(password)
  end
  
  def use
    yield @username, password_decrypt
  end
  
  private
  
  def make_key
    @key = Digest::SHA256.hexdigest(@params[:salt] || (@username.to_s + Random.rand(2 ** 31).to_s))
  end
  
  def password_encrypt(password)
    @password_crypted = if password.kind_of?(String) && password.length > 0
      Encryptor.encrypt(password, key: @key)
    else
      nil
    end
  end
  
  def password_decrypt
    if @password_crypted.kind_of?(String) && @password_crypted.length > 0
      Encryptor.decrypt(@password_crypted, key: @key)
    else
      nil
    end
  end
end
