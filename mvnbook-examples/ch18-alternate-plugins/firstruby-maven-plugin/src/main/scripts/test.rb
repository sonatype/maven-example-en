# This is a mojo description
# @goal test
# @phase validate
class Test < Mojo
  # @parameter type="java.lang.String" default-value="nothing" alias="a_string"
  def prop
  end  

  # @parameter type="org.apache.maven.project.MavenProject" expression="${project}"
  # @required true  
  def project
  end  

  def execute    
    info "The following String was passed to prop: '#{$prop}'"    
    info "My project artifact is: #{$project.artifactId}"  
  end
end

run_mojo Test