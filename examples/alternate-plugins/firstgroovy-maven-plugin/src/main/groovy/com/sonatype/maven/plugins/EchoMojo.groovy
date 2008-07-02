package com.sonatype.maven.plugins

import org.codehaus.mojo.groovy.GroovyMojo

/**
 * Example goal which echos a message
 *
 * @goal echo
 */
class EchoMojo extends GroovyMojo {

    /**
     * Message to print
     *
     * @parameter expression="${echo.message}" 
     *            default-value="Hello Maven World"
     */
    String message

    void execute() {
      log.info( message )
    }
}
