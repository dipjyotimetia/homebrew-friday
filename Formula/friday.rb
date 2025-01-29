class Friday < Formula
    include Language::Python::Virtualenv
    
    desc "AI Test Case Generator CLI"
    homepage "https://github.com/dipjyotimetia/friday"
    url "https://github.com/dipjyotimetia/friday/archive/refs/tags/v0.1.34.tar.gz"
    sha256 "b6005ef382c89978f4c7d6fd20138e2e436650f961961c0c246e83f7806918bf"
    license "MIT"
  
    depends_on "python@3.12"
  
    def install
      # Create virtualenv in libexec
      venv = virtualenv_create(libexec, "python3.12")
      
      # Install pip explicitly first
      venv.pip_install "pip"
      
      # Install dependencies
      system libexec/"bin/pip", "install", "-r", "requirements.txt"
      
      # Install the package itself
      system libexec/"bin/pip", "install", "."
  
      # Only symlink the friday executable, not python/pip
      (bin/"friday").write_env_script libexec/"bin/friday",
        PATH: "#{libexec}/bin:$PATH",
        PYTHONPATH: "#{libexec}/lib/python3.12/site-packages:#{ENV["PYTHONPATH"]}"
    end
  
    test do
      assert_match "friday version", shell_output("#{bin}/friday version")
    end
  end