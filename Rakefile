x = lambda { |str| File.expand_path str }
require 'fileutils'

desc "Installs."
task :setup => [
  :'setup:link',     # Link me
  :'setup:vimrc',    # Make a symlink to ~/.vimrc
  :'setup:_after'
]

task :install => :setup

# ============================================================================

def status(str)
  puts "\033[0;34m==>\033[0;32m #{str}\033[0;m"
end

namespace :setup do
  task :link do
    if File.exists?(x['~/.vim'])
      status "~/.vim exists. Remove it first."
      exit
    end

    status "Linking to ~/.vim"
    FileUtils.ln_s Dir.pwd, x['~/.vim']
  end

  task :vimrc do
    if File.exists?(x['~/.vimrc'])
      fn = "~/.vimrc.#{Time.now.to_i.to_s}"
      status "Moving aside your .vimrc to #{fn}..."
      FileUtils.mv x["~/.vimrc"], x[fn]
    end

    status "Installing ~./vimrc..."
    FileUtils.ln_s "#{Dir.pwd}/vimrc.vim", x["~/.vimrc"]
  end

  task :_after do
    puts ""
    status "OK! Hooray!"
  end
end

# ============================================================================

def get_origin_url
  output = `git remote -v`.split("\n")
  line = output.select { |line| line =~ /^origin\t/ }.first
  return unless line
  line.split("\t")[1].split(' ')[0]
end

desc "Add bundles installed by Vundle into submodules."
task :'submodule:sync' do
  require 'fileutils'
  lines = []
  Dir['./bundle/*'].each do |bundle_path|
    Dir.chdir bundle_path do
      url = get_origin_url
      bundle_path =~ /^.\/(.*)$/ && bundle_path = $1
      lines << %<[submodule "#{bundle_path}"]>
      lines << %<  path = #{bundle_path}>
      lines << %<  url = #{url}>
    end
  end
  script = lines.join("\n") + "\n"
  File.open('.gitmodules', 'w') { |f| f.write script }
  puts File.read('.gitmodules')
end

desc "Help"
task :'help' do
  puts "mapleader:"
  system %[cat plugin/* | grep "let mapleader"]

  puts ""
  puts "leader:"
  system %[cat plugin/* vimrc.vim | grep "map <leader>"]

  puts ""
  puts "mappings:"
  system %[cat plugin/* vimrc.vim | grep "^  \\"\\""]
end
