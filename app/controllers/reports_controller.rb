class ReportsController < ApplicationController
# added 2008.06.10 added
before_filter :login_required
  def kosei
    @boys = Boy.find(:all)

    @boys_danshi = Boy.find(:all, :conditions =>['sex=?',1]).size
    @boys_joshi = Boy.find(:all, :conditions =>['sex=?',2]).size

    @otoko = @boys.select{|i| i.sex == 1}
    @otoko05 = @otoko.select {|i| (0..5) === i.birthdate.age}.size
    @otoko611 = @otoko.select {|i| (6..11) === i.birthdate.age}.size
    @otoko1214 = @otoko.select {|i| (12..14) === i.birthdate.age}.size
    @otoko1517 = @otoko.select {|i| (15..17) === i.birthdate.age}.size
    @otoko1825 = @otoko.select {|i| (18..25) === i.birthdate.age}.size

    @onna = @boys.select{|i| i.sex == 2}
    @onna05 = @onna.select {|i| (0..5) === i.birthdate.age}.size
    @onna611 = @onna.select {|i| (6..11) === i.birthdate.age}.size
    @onna1214 = @onna.select {|i| (12..14) === i.birthdate.age}.size
    @onna1517 = @onna.select {|i| (15..17) === i.birthdate.age}.size
    @onna1825 = @onna.select {|i| (18..25) === i.birthdate.age}.size
  end
end