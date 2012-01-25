def logged_in_users
  `who`.lines.collect { |line| line.split.first }
end
