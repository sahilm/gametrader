module Omniauth
  def auth_params(email=nil)
    { 'provider' => 'Facebook',
      'uid' => '123',
      'info' =>
      {
        'email'      => email || 'foobar@example.org',
        'image'      => 'http://example.com/image',
        'first_name' => 'foo',
        'last_name'  => 'bar'
      }
    }
  end
end