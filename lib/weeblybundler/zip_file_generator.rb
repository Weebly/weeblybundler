require 'zip'

# Recursively zips contents of a directory. 
# https://github.com/rubyzip/rubyzip/blob/05916bf89181e1955118fd3ea059f18acac28cc8/samples/example_recursive.rb
#
# Usage:
#   directoryToZip = "/tmp/input"
#   outputFile = "/tmp/out.zip"
#   zf = ZipFileGenerator.new(directoryToZip, outputFile)
#   zf.write()
module Weeblybundler
  class ZipFileGenerator

    # Initialize with the directory to zip and the location of the output archive.
    def initialize(inputDir, outputFile)
      @inputDir = inputDir
      @outputFile = outputFile
    end

    # Zip the input directory.
    def write()
      entries = Dir.entries(@inputDir)
      entries.delete_if { |entry| entry.start_with? '.' }
      io = Zip::File.open(@outputFile, Zip::File::CREATE);

      writeEntries(entries, "", io)
      io.close()
    end

    # A helper method to make the recursion work.
    private

    def writeEntries(entries, path, io)
      entries.each { |e|
        zipFilePath = path == "" ? e : File.join(path, e)
        diskFilePath = File.join(@inputDir, zipFilePath)
        if  File.directory?(diskFilePath)
          io.mkdir(zipFilePath)
          subdir =Dir.entries(diskFilePath)
          subdir.delete_if { |entry| entry.start_with? '.' }
          writeEntries(subdir, zipFilePath, io)
        else
          io.get_output_stream(zipFilePath) { |f| f.puts(File.open(diskFilePath, "rb").read())}
        end
      }
    end

  end
end
