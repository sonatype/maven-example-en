# This mojo tests plexus integration
# @goal testplexus
# @phase validate
class TestPlexus < Mojo

  # @parameter type="org.codehaus.plexus.archiver.Archiver" expression="${component.org.codehaus.plexus.archiver.Archiver#zip}"
  def archiver
  end  

  def execute    
    info $archiver
  end
end

run_mojo TestPlexus