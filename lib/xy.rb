module XY
  COLORS = [24, 60, 96, 132, 168, 204, 210, 216, 222, 228]
  GREY = 240

  module_function

  def wrap(str, *clrs)
    "\033[#{clrs.join(';')}m#{str}\033[0m"
  end

  def fg(str, clr)
    wrap(str, 38, 5, clr)
  end

  def bg(str, clr)
    wrap(str, 48, 5, clr)
  end

  def grey(str)
    fg(str, GREY)
  end

  BARS = (0..49).map do |i|
    fg('█' * i, COLORS[i / 5]) + fg('░' * (49 - i), GREY)
  end

  LINES = ' ▁▁▂▃▄▅▆▇█'.chars.map.with_index do |c, i|
    fg(c, COLORS[i])
  end

  def chart_index(n, min_n, max_n, max_index)
    return 0 if (max_n - min_n).to_i == 0
    (max_index * ((n - min_n) / (max_n - min_n))).to_i
  end

  def pcnt(n, sum)
    return "0.0%" if sum == 0.0
    "#{((n / sum) * 100).round(1)}%"
  end

  def chart(type = :bar, arr = [])
    return unless
      arr.is_a?(Array) &&
      arr.all? { |n| n.is_a?(Numeric) } &&
      arr.length > 0

    max_strlen = [arr.map(&:to_s).map(&:length).max, 4].max
    min_n = Float(arr.min)
    max_n = Float(arr.max)
    sum = Float(arr.inject(:+))
    cols = (32 / max_strlen).to_i

    "\n" +
    case type.to_sym
    when :bar
      arr.map do |n|
        "#{n.to_s.rjust(max_strlen, ' ')} #{BARS[chart_index(n, min_n, max_n, 49)]} #{grey(pcnt(n, sum))}"
      end.join("\n")

    when :spark
      arr.map do |n|
        LINES[chart_index(n, min_n, max_n, 9)]
      end.join

    when :block
      divider = grey(cols.times.map { '─' * max_strlen }.join("─┼─"))
      arr.each_slice(cols).map do |row|
        [ row.map { |i| LINES[chart_index(i, min_n, max_n, 9)] * max_strlen }.join(grey(" │ ")),
          row.map { |i| i.to_s.ljust(max_strlen, ' ') }.join(grey(" │ ")) ].join("\n")
      end.join("\n#{divider}\n")
    end
  end

  def bar(arr)
    chart :bar, arr
  end

  def spark(arr)
    chart :spark, arr
  end

  def block(arr)
    chart :block, arr
  end
end
