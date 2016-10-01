Simulator  # must eval `Simulator` to ensure Simulator class is loaded
class Simulator

  def parameter_sets_in_dataframe(where: nil, with_results: nil)
    pss = parameter_sets.asc(:id)
    pss = pss.where(where) if where
    param_keys = parameter_definitions.map(&:key)
    rows = pss.map do |ps|
      mapped = param_keys.map {|key| ps.v[key] }
      mapped += with_results.map {|r| ps.average_result(r) } if with_results
      mapped
    end
    ids = pss.map(&:id)

    keys = param_keys + with_results.to_a

    Daru::DataFrame.rows( rows, order: keys, index: ids )
  end
end

ParameterSet
class ParameterSet

  def average_result(key, error: false)
    results = runs.where(status: :finished).only(:result).map {|r| r.result[key] }
    n = results.size
    avg = results.inject(:+) / n
    if error
      r2_sum = results.inject(0.0) {|sum,x| (x-avg)**2}
      return [avg, Math.sqrt(r2_sum/(n-1.0)) ]
    else
      return avg
    end
  end
end

