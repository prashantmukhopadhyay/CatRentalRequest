

cat1 = Cat.new({
  name: "Whiskers",
  age: "3",
  color: "Yellow",
  sex: "M",
  birthday: "09/08/2010"
}).save!

cat2 = Cat.new({
  name: "Carlos",
  age: "7",
  color: "Black",
  sex: "M",
  birthday: "09/08/2006"
}).save!

request1 = CatRentalRequest.new({
  cat_id: 1,
  start_date: "11/11/2013",
  end_date: "27/11/2013",
  status: "PENDING"
}).save!

request2 = CatRentalRequest.new({
  cat_id: 1,
  start_date: "15/11/2013",
  end_date: "29/11/2013",
  status: "PENDING"
}).save!