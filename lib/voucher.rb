class Voucher
  def initialize(items, taxes, total)
    @items = items
    @taxes = taxes
    @total = total
  end

  def show
    @items.each do |item|
      print_line(item)
    end
    print_taxes(@taxes)
    print_total(@total)
    puts "\n\n"
  end

  private

  def print_line(item)
    print "#{item[:qty]} "
    print item[:item].is_imported ? "imported " : ""
    puts "#{item[:item].name}: #{item[:total]}"
  end

  def print_taxes(taxes)
    puts "Sales Taxes: #{taxes}"
  end

  def print_total(total)
    puts "Total: #{total}"
  end
end
