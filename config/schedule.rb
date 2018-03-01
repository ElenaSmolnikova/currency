every :minute do#:hour, at: 0 do
  runner "RateUpdater.perform"
end
