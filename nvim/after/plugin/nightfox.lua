require('nightfox').setup {
  options = {
    colorblind = {
      enable = true,
      severity = {
        deutan = 1,
        protan = 0.5,
        tritan = 0.2,
      },
    },
  },
}
