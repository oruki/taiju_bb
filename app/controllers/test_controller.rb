class TestController < ApplicationController

def calculate
 if request.post?
  @errors = []
  arg1 = convert_float(:arg1)
  arg2 = convert_float(:arg2)
  op   = convert_operator(:operator)

  if @errors.empty?
    begin
      @result = op.call(arg1, arg2)
    rescue Exception => err
      @result = err.message
    end
  end
 end
end

private

def convert_float(name)
  if params[name].blank?
     @errors << "#{name}does not exist;"
  else
    begin
      Float(params[name])
    rescue
      @errors << "#{name}:#{err.message}"
      nill
    end
  end
end


def convert_operator(name)
  case params[name]
  when "+" then proc {|a,b| a+b}
  when "-" then proc {|a,b| a-b}
  when "*" then proc {|a,b| a*b}
  when "/" then proc {|a,b| a/b}
  else
    @errors << "unknown operator"
    nil
  end
end

end