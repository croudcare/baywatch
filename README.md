# Baywatch

[![Code Climate](https://codeclimate.com/repos/520379417e00a429dc02c367/badges/6a679ba794edb297e6e0/gpa.png)](https://codeclimate.com/repos/520379417e00a429dc02c367/feed)

## Installation

Add this line to your application's Gemfile:

    gem 'baywatch', :git => https://github.com/croudcare/baywatch.git

And then execute:

    $ bundle


## Usage

Declarative way to error handling inside controller

````

  class UsersController < ApplicationController
    include Baywatch::Rescue

    # By default will handle([ Errno::ECONNREFUSED, Errno::ECONNRESET ])
    service_down do |on|      
      on.index do
        flash[:error] = "Sorry, the service is not working properly"
      end
      on.create do 
        flash[:error] = "Sorry, we cannot save right now"
        flash.keep(:error)
        redirect root_url
      end
    end
    
    def index
      @users = Users.all
    end
    
    def create
      @user = User.create(params[:user])
      @user.save
    end
    
  end
  
````

### TODO
##### Handle Contextual Exception
 
 ```
  service_down do |on|
  
    on.edit(ActiveRecord::RecordNotFound)
      flash[:error] = "Not Found"
      redirect_to root_url
    end
    
    on.edit(Base::WhateverException)
      flash[:error] = "Whatever Message Here"
      MailAdministrator.send(:fail")
      redirect_to root_url
    end
  end
 ```
 
## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Cover with tests
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`) 
6. Create new Pull Request
