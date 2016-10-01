Simulator  # must eval `Simulator` to ensure Simulator class is loaded
class Simulator

  # with_results: keys of results. can be either nil, string, or array of strings.
  def parameter_sets_in_dataframe(where: nil, with_results: nil)
    pss = parameter_sets.asc(:id)
    pss = pss.where(where) if where
    param_keys = parameter_definitions.map(&:key)
    rows = pss.map do |ps|
      mapped = param_keys.map {|key| ps.v[key] }
      mapped += Array(with_results).map {|r| ps.average_result(r) }
      mapped
    end
    ids = pss.map(&:id)

    keys = param_keys + Array(with_results)

    Daru::DataFrame.rows( rows, order: keys, index: ids )
  end

  def to_html
    tags = [:id,:name,:command,:description].map do |key|
      "<tr><th>#{key}</th><td>#{self.send(key)}</td></tr>"
    end
    link = "<a href=http://localhost:3000/simulators/#{id} target=\"_blank\" >link</a>"
    "<table>" + tags.join + "</table>" + link
  end
end

ParameterSet
class ParameterSet

  def average_result(key, error: false)
    results = runs.where(status: :finished).only(:result).map {|r| r.result[key] }.compact
    n = results.size
    return nil if n == 0
    avg = results.inject(:+) / n
    if error
      r2_sum = results.inject(0.0) {|sum,x| (x-avg)**2}
      err = n > 1 ? Math.sqrt(r2_sum/(n-1.0)) : nil
      return [avg, err]
    else
      return avg
    end
  end
end

