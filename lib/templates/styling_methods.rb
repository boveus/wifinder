module StylingMethods
  def head
    "<head>
    #{css}
    #{local_styles}
    </head>"
  end

  def local_styles
    "<style>
    #{File.read("./lib/styles/styles.css")}
    </style>"
  end

  def css
    "<link href='https://cdn.jsdelivr.net/npm/tailwindcss/dist/tailwind.min.css' rel='stylesheet'>"
  end

  def header_classes
    "\"text-5x1 font-mono text-grey-darkest text-center pb-5\""
  end

  def p_classes
    "\"text-5x1 font-mono text-grey-darkest\""
  end

  def button_to(href, text, classes=nil)
    "<a href='#{href}'>
      <button class=\"bg-white hover:bg-grey-lightest text-grey-darkest
      font-semibold py-2 px-4 border border-grey-light rounded shadow #{classes}\">
         #{text}
      </button>
    </a>"
  end
end
