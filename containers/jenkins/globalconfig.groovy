import hudson.model.*
import jenkins.model.*

println "--> Set global Git configuration name and email address"
def inst = Jenkins.getInstance()
def desc = inst.getDescriptor("hudson.plugins.git.GitSCM")
desc.setGlobalConfigName("Git Gitsson")
desc.setGlobalConfigEmail("no-reply@whatever.com")
inst.save()
