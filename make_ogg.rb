files = Dir.glob('**/*.mp3')
files.each do |f|    
  `avconv -y -i "#{f}" #{f.sub('.mp3', '.ogg')}`
end

