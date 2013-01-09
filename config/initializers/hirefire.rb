HireFire.configure do |config|
  config.environment      = nil # default in production is :heroku. default in development is :noop
  config.max_workers      = 6   # default is 1
  config.min_workers      = 0   # default is 0
  config.job_worker_ratio = [
      { :jobs => 1,   :workers => 1 },
      { :jobs => 50,  :workers => 2 },
      { :jobs => 200,  :workers => 3 },
      { :jobs => 500,  :workers => 4 },
      { :jobs => 1000,  :workers => 5 },
      { :jobs => 1500,  :workers => 6 }

    ]
end
