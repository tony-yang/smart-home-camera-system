threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
threads threads_count, threads_count

environment 'production'
daemonize true
bind 'ssl://127.0.0.1:3000?key=/root/ssl/ystpublic.camera.key&cert=/root/ssl/ystpublic.camera.crt'

plugin :tmp_restart
