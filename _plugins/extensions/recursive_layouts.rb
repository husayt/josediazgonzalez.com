# Title: Recursive Layouts Jekyll Extension
# Description: Monkeypatch Site::read_layouts() to read layout files from subdirectories

module Jekyll
  class Site
    # Monkeypatch Site::read_layouts() to read layout files from subdirectories
    def read_layouts(dir = '')
      base = File.join(self.source, dir, "_layouts")
      return unless File.exists?(base)
      entries = []
      Dir.chdir(base) { entries = filter_entries(Dir.glob('**/*.*')) }

      entries.each do |f|
        name = f.split(".")[0..-2].join(".")
        self.layouts[name] = Layout.new(self, base, f)
      end
    end
  end
end