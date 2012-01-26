def logged_in_users
  `who`.lines.collect { |line| line.split.first }.uniq
end

def load_average
  `uptime`[/load averages: (.*)/, 1].split
end