threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
threads threads_count, threads_count

environment 'production'
daemonize true
bind "ssl://127.0.0.1:3000?key=#{ENV.fetch('SSL_KEY_PATH')}&cert=#{ENV.fetch('SSL_CERT_PATH')}"

plugin :tmp_restart
