class PrinterController < ApplicationController
  def csv_out
    @boys = Boy.find(:all)
    text = render_to_string
    send_data text, :filename => "pon.csv", :type => "text/csv", :disposition => "inline"
  end

  def html_out
    @boys = Boy.find(:all)
    text = render_to_string
    send_data text, :filename => "pon.xls", :type => "application/vnd.ms-excel", :disposition => "inline"
  end

end