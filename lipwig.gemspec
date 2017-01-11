# coding: utf-8

Gem::Specification.new do |spec|
  spec.name          = "lipwig"
  spec.version       = '0.0.1'
  spec.authors       = ["Pat Allan"]
  spec.email         = ["pat@freelancing-gods.com"]

  spec.summary       = %q{Write group emails in Markdown, send via Postmark.}
  spec.homepage      = "https://github.com/pat/lipwig"

  spec.files         = `git ls-files -z`.split("\x0").reject do |file|
    file.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |file| File.basename(file) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "redcarpet", "~> 3.3"

  spec.add_development_dependency "rspec", "~> 3.0"
end
