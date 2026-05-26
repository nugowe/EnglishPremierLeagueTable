# =========================================================
# PACKAGES
# =========================================================

packages = c("gt", "htmltools", "glue", "dplyr", "scales")

for(package in packages){install.packages(package)}



library(gt)
library(htmltools)
library(glue)
library(dplyr)
library(scales)


# =========================================================
# EPL TABLE (2025/26 UPDATED)
# =========================================================
EPLTable <- data.frame(

  Pos = 1:20,

  Team = c(
    "Arsenal",
    "Manchester City",
    "Manchester United",
    "Aston Villa",
    "Liverpool",
    "Bournemouth",
    "Sunderland",
    "Brighton & Hove Albion",
    "Brentford",
    "Chelsea",
    "Fulham",
    "Newcastle United",
    "Everton",
    "Leeds United",
    "Crystal Palace",
    "Nottingham Forest",
    "Tottenham Hotspur",
    "West Ham United",
    "Burnley",
    "Wolverhampton Wanderers"
  ),

  Pld = rep(38, 20),

  W = c(
    26,23,20,19,17,
    13,14,14,14,14,
    15,14,13,11,11,
    11,10,10,4,3
  ),

  D = c(
    7,9,11,8,9,
    18,12,11,11,10,
    7,7,10,14,12,
    11,11,9,10,11
  ),

  L = c(
    5,6,7,11,12,
    7,12,13,13,14,
    16,17,15,13,15,
    16,17,19,24,24
  ),

  GF = c(
    71,77,69,56,63,
    58,42,52,55,58,
    47,53,47,49,41,
    48,48,46,38,27
  ),

  GA = c(
    27,35,50,49,53,
    54,48,46,52,52,
    51,55,50,56,51,
    51,57,65,75,68
  ),

  GD = c(
    44,42,19,7,10,
    4,-6,6,3,6,
    -4,-2,-3,-7,-10,
    -3,-9,-19,-37,-41
  ),

  Pts = c(
    85,78,71,65,60,
    57,54,53,53,52,
    52,49,49,47,45,
    44,41,39,22,20
  ),

  Qual = c(
    "UCL",
    "UCL",
    "UCL",
    "UCL",
    "UCL",
    "UEL",
    "",
    "UECL",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "",
    "Relegated",
    "Relegated",
    "Relegated"
  )
)

# =========================================================
# CLUB LOGOS
# =========================================================
logos <- c(

  "Arsenal"="https://upload.wikimedia.org/wikipedia/en/5/53/Arsenal_FC.svg",

  "Manchester City"="https://upload.wikimedia.org/wikipedia/en/e/eb/Manchester_City_FC_badge.svg",

  "Manchester United"="https://upload.wikimedia.org/wikipedia/en/7/7a/Manchester_United_FC_crest.svg",

  "Aston Villa"="https://upload.wikimedia.org/wikipedia/en/9/9a/Aston_Villa_FC_new_crest.svg",

  "Liverpool"="https://upload.wikimedia.org/wikipedia/en/0/0c/Liverpool_FC.svg",

  "Bournemouth"="https://upload.wikimedia.org/wikipedia/en/e/e5/AFC_Bournemouth_%282013%29.svg",

  "Sunderland"="https://upload.wikimedia.org/wikipedia/en/7/77/Logo_Sunderland.svg",

  "Brighton & Hove Albion"="https://upload.wikimedia.org/wikipedia/en/f/fd/Brighton_%26_Hove_Albion_logo.svg",

  "Brentford"="https://upload.wikimedia.org/wikipedia/en/2/2a/Brentford_FC_crest.svg",

  "Chelsea"="https://upload.wikimedia.org/wikipedia/en/c/cc/Chelsea_FC.svg",

  "Fulham"="https://upload.wikimedia.org/wikipedia/en/e/eb/Fulham_FC_%28shield%29.svg",

  "Newcastle United"="https://upload.wikimedia.org/wikipedia/en/5/56/Newcastle_United_Logo.svg",

  "Everton"="https://upload.wikimedia.org/wikipedia/en/7/7c/Everton_FC_logo.svg",

  "Leeds United"="https://upload.wikimedia.org/wikipedia/en/5/54/Leeds_United_F.C._logo.svg",

  "Crystal Palace"="https://upload.wikimedia.org/wikipedia/en/a/a2/Crystal_Palace_FC_logo_%282022%29.svg",

  "Nottingham Forest"="https://upload.wikimedia.org/wikipedia/en/e/e5/Nottingham_Forest_F.C._logo.svg",

  "Tottenham Hotspur"="https://upload.wikimedia.org/wikipedia/en/b/b4/Tottenham_Hotspur.svg",

  "West Ham United"="https://upload.wikimedia.org/wikipedia/en/c/c2/West_Ham_United_FC_logo.svg",

  "Burnley"="https://upload.wikimedia.org/wikipedia/en/6/6d/Burnley_FC_Logo.svg",

  "Wolverhampton Wanderers"="https://upload.wikimedia.org/wikipedia/en/f/fc/Wolverhampton_Wanderers.svg"
)

EPLTable$Badge <- logos[EPLTable$Team]

# =========================================================
# TOP SCORER
# =========================================================
TopScorer <- "Erling Haaland"
TopGoals <- 27

TopScorerImg <- "https://resources.premierleague.com/premierleague/photos/players/250x250/p223094.png"

ManCityLogo <- logos["Manchester City"]

EPLLogo <- "https://upload.wikimedia.org/wikipedia/en/f/f2/Premier_League_Logo.svg"

# =========================================================
# REORDER COLUMNS
# =========================================================
EPLTable <- EPLTable %>%
  select(
    Pos,
    Badge,
    Team,
    Pld,
    W,
    D,
    L,
    GF,
    GA,
    GD,
    Pts,
    Qual
  )

# =========================================================
# BUILD GT TABLE
# =========================================================
EPL_GT <- gt(EPLTable) %>%

  # =====================================================
  # BADGES
  # =====================================================
  text_transform(
    locations = cells_body(columns = Badge),
    fn = function(x) {
      web_image(EPLTable$Badge, height = 30)
    }
  ) %>%

  cols_label(
    Badge = ""
  ) %>%

  # =====================================================
  # HEADER
  # =====================================================
  tab_header(

    title = html(glue("
      <div style='text-align:center;'>

        <img src='{EPLLogo}'
             style='height:90px;'>

      </div>
    ")),

    subtitle = html(glue("

      <div style='
        background:#F5F5F5;
        padding:20px;
        border-radius:18px;

        display:flex;
        justify-content:center;
        align-items:center;
        gap:28px;
      '>

        <img src='{ManCityLogo}'
             style='height:70px;'>

        <img src='{TopScorerImg}'
             style='height:150px;width:150px;'>

        <div style='text-align:left;'>

          <div style='
            background:#D00000;
            color:white;

            padding:6px 14px;

            border-radius:10px;

            font-size:13px;
            font-weight:bold;

            display:inline-block;
          '>

            TOP GOAL SCORER

          </div>

          <h2 style='margin:10px 0 0 0;'>

            {TopScorer}

          </h2>

          <h3 style='margin:0;color:#D00000;'>

            {TopGoals} Goals

          </h3>

        </div>

      </div>

    "))
  ) %>%

  # =====================================================
  # COLUMN WIDTHS
  # =====================================================
  cols_width(
    Team ~ px(320),
    Qual ~ px(180)
  ) %>%

  # =====================================================
  # ALIGNMENT
  # =====================================================
  cols_align(
    columns = everything(),
    align = "center"
  ) %>%

  cols_align(
    columns = Team,
    align = "left"
  ) %>%

  # =====================================================
  # COLORS
  # =====================================================
  data_color(
    W,
    colors = col_numeric(
      c("#E8F5E9", "#2E7D32"),
      NULL
    )
  ) %>%

  data_color(
    D,
    colors = col_numeric(
      c("#FFF8E1", "#FFB300"),
      NULL
    )
  ) %>%

  data_color(
    L,
    colors = col_numeric(
      c("#FDECEC", "#C62828"),
      NULL
    )
  ) %>%

  data_color(
    GF,
    colors = col_numeric(
      c("#E3F2FD", "#1565C0"),
      NULL
    )
  ) %>%

  data_color(
    Pts,
    colors = col_numeric(
      c("#E3F2FD", "#64B5F6"),
      NULL
    )
  ) %>%

  # =====================================================
  # UCL POINTS BLACK TEXT
  # =====================================================
  tab_style(
    style = cell_text(
      color = "black",
      weight = "bold"
    ),

    locations = cells_body(
      columns = Pts,
      rows = 1:5
    )
  ) %>%

  # =====================================================
  # CHAMPIONS
  # =====================================================
  tab_style(
    style = list(
      cell_fill(color = "#FFF8E1"),
      cell_text(weight = "bold")
    ),

    locations = cells_body(
      rows = 1
    )
  ) %>%

  # =====================================================
  # UCL QUALIFIERS
  # =====================================================
  tab_style(
    style = list(
      cell_fill(color = "#E8F0FE")
    ),

    locations = cells_body(
      rows = 1:5
    )
  ) %>%

  # =====================================================
  # RELEGATION
  # =====================================================
  tab_style(
    style = list(
      cell_fill(color = "#FDECEC")
    ),

    locations = cells_body(
      rows = 18:20
    )
  ) %>%

  # =====================================================
  # FONT
  # =====================================================
  opt_table_font(
    font = google_font("Roboto Condensed")
  ) %>%

  # =====================================================
  # TABLE OPTIONS
  # =====================================================
  tab_options(

    table.width = pct(100),

    container.width = pct(100),

    table.font.size = px(14),

    data_row.padding = px(8),

    table.border.top.width = px(0),

    table.border.bottom.width = px(0)
  ) %>%

  # =====================================================
  # FULLSCREEN CSS
  # =====================================================
  opt_css("
    body {
      zoom: 1.08;
      background: #FFFFFF;
    }
  ") %>%

  # =====================================================
  # SOURCE NOTES
  # =====================================================
  tab_source_note(
    source_note = md(
      'Source: Premier League + Wikipedia'
    )
  ) %>%

  tab_source_note(
    source_note = glue(
      'Updated: {Sys.time()}'
    )
  )

# =========================================================
# SAVE HTML
# =========================================================
file <- "/opt/epl/TableEPL.html"

gtsave(EPL_GT, file)

# =========================================================
# MASSIVE CONFETTI SCRIPT
# =========================================================
html <- readLines(file)

confetti_script <- "

<script src='https://cdn.jsdelivr.net/npm/canvas-confetti@1.9.3/dist/confetti.browser.min.js'></script>

<script>

function fireConfetti() {

  // LEFT CANNON
  confetti({
    particleCount: 140,
    angle: 60,
    spread: 140,
    origin: { x: 0, y: 0.60 }
  });

  // RIGHT CANNON
  confetti({
    particleCount: 140,
    angle: 120,
    spread: 140,
    origin: { x: 1, y: 0.60 }
  });

  // TOP CENTER BURST
  confetti({
    particleCount: 220,
    spread: 180,
    startVelocity: 45,
    origin: { y: 0.02 }
  });

  // RANDOM FLOATING BURST
  confetti({
    particleCount: 80,
    spread: 360,
    scalar: 1.2,
    origin: {
      x: Math.random(),
      y: Math.random() * 0.4
    }
  });

}

setInterval(fireConfetti, 1400);

</script>
"

html <- sub(
  "</body>",
  paste0(confetti_script, "\n</body>"),
  html
)

writeLines(html, file)

# =========================================================
# OUTPUT
# =========================================================
cat('Saved to:\\n')
cat(normalizePath(file))
cat('\\n')