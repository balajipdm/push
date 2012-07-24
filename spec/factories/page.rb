Factory.define :page do |f|
  f.sequence(:title) {|n| "Title #{n}"}
  f.content "The world goes around."
end
