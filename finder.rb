class Finder
  attr_reader :reponame

  def initialize(reponame)
     if !File.directory?('temp')
       %x(mkdir temp )
     end
    @reponame = reponame
    x = %x(git clone #{reponame} temp )
  end

  def all_contributors
    Dir.chdir "temp"
    output = %x( git log )
    output.force_encoding("ISO-8859-1").encode("utf-8", replace: nil)

    for_emails = Regexp.new(/(?<=Author: ).+/)

    contributors = output.scan(for_emails)
    print_contribs(contributors)
  end

  def print_contribs(contributors)
    contributors.uniq!
    contributors.each { |contributor| puts contributor }
  end
end
