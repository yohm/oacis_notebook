Simulator  # must eval `Simulator` to ensure Simulator class is loaded
class Simulator

  def parameter_sets_in_dataframe(where: nil, result_keys: nil)
    pss = parameter_sets.asc(:id)
    pss = pss.where(where) if where
    param_keys = parameter_definitions.map(&:key)
    rows = pss.map do |ps|
      mapped = param_keys.map {|key| ps.v[key] }
      if result_keys
        avgs = result_keys.map {|rkey| ps.average_result(rkey)[0] }
        mapped += avgs
      end
      mapped
    end
    ids = pss.map(&:id)

    keys = param_keys + result_keys.to_a

    Daru::DataFrame.rows( rows, order: keys, index: ids )
  end
end

ParameterSet
class ParameterSet

  def average_result(key)
    results = runs.where(status: :finished).only(:result).map {|r| r.result[key] }
    n = results.size
    avg = results.inject(:+) / n
    r2_sum = results.inject(0.0) {|sum,x| (x-avg)**2}
    [avg, Math.sqrt(r2_sum/(n-1.0)) ]
  end
end

