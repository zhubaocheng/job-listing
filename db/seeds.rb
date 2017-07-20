# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "這個種子檔會自動建立一個admin帳號, 並且創建 10 個 public jobs, 以及10個hidden jobs"

create_account = User.create([email: 'test@gmail.com', password: '888888', password_confirmation: '888888', is_admin: 'true'])
puts "Admin account created."

jobs_info = [['招聘RoR工程师', '全栈工程师能力'],
  ['招聘文案设计', '策划编辑能力'],
  ['招聘UI设计师', '审美能力'],
  ['招聘Android开发工程师', '安卓技术开发能力'],
  ['招聘产品经理', '产品设计认知能力'],
  ['招聘前端开发工程师', '前端开发能力'],
  ['招聘市场营销', '市场营销策划能力'],
  ['招聘php后台研发工程师', 'php技术能力'],
  ['招聘python工程师', 'pythen技术能力'],
  ['招聘高级JAVA研发工程师', 'java技术开发能力'],
  ['招聘高级数据挖掘工程师', '数据挖掘能力']]

company_info = [['阿里巴巴', '杭州'],['腾讯', '深圳'],['百度', '北京'],['京东', '北京'],
               ['平安陆金所', '上海'],['美团网', '北京'],['Fittime', '无锡'],
               ['膜拜单车', '上海'],['搜狐', '广州'],['新浪', '苏州'],['网易', '广州']]


create_jobs = for i in 1..10 do
  job_test = jobs_info[rand(0..10)]
  company_test = company_info[rand(0..10)]
  Job.create!([title: job_test[0], description: job_test[1], wage_lower_bound: rand(10..49)*100,
              wage_upper_bound: rand(50..300)*100, company: company_test[0], city: company_test[1], experience: rand(1..10), contact_email: test@gmail.com, is_hidden: false])
end
puts "10 Public jobs created."

create_jobs = for i in 1..10 do
  job_test = jobs_info[rand(0..10)]
  company_test = company_info[rand(0..10)]
  Job.create!([title: job_test[0], description: job_test[1], wage_lower_bound: rand(10..49)*100,
              wage_upper_bound: rand(50..200)*100, company: company_test[0], city: company_test[1], experience: rand(1..10), contact_email: test@gmail.com, is_hidden: true])
end
puts "10 hidden jobs created."
