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
end
