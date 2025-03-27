#define _GNU_SOURCE
#include <getopt.h>
#include <regex.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define N 10000

typedef struct flags {
  int e;
  int i;
  int v;
  int c;
  int l;
  int n;
  int h;
  int s;
  int f;
  int o;
  int fl_count;
  int t_count;
  char templates[N];
} Flags;

int flag_reader(int argc, char *argv[], Flags *selected_flags);
void open(int argc, char *argv[], Flags *selected_flags, int how_many);
void cycle(char *argv[], Flags *selected_flags, FILE *file, regex_t regex,
           regmatch_t regmatch, int how_many);
void empty_template(char *argv[], Flags *selected_flags);
int how_many_calc(int argc, Flags *selected_flags);
void priority(Flags *selected_flags);
void grep(char *argv[], Flags *selected_flags, char *line, int how_many);
void flag_e(Flags *selected_flags);
void flag_c(char *argv[], Flags *selected_flags, char *line, int how_many,
            int count);
int flag_l(char *argv[], char *line);
void flag_n(char *argv[], Flags *selected_flags, char *line, int string,
            int how_many);
void flag_h(Flags *selected_flags, char *line);
void flag_f(Flags *selected_flags);
void flag_o(char *argv[], Flags *selected_flags, regex_t regex,
            regmatch_t regmatch, char *line, int string, int how_many);

int main(int argc, char *argv[]) {
  Flags selected_flags = {0};
  int mark = 0;
  mark = flag_reader(argc, argv, &selected_flags);
  if (!selected_flags.e && !selected_flags.f) {
    empty_template(argv, &selected_flags);
  }
  if (mark == 1 || argc < 3) {
    fprintf(stderr, "usage: simple_grep [-eivclnhsfo] pattern [file ...]");
  } else {
    int how_many = how_many_calc(argc, &selected_flags);
    open(argc, argv, &selected_flags, how_many);
  }
  return 0;
}

int flag_reader(int argc, char *argv[], Flags *selected_flags) {
  int mark = 0, select;
  while ((select = getopt_long(argc, argv, "e:ivclnhsf:o", NULL, NULL)) != -1) {
    switch (select) {
      case 'e':
        selected_flags->e = 1, selected_flags->fl_count++;
        flag_e(selected_flags);
        break;
      case 'i':
        selected_flags->i = 1, selected_flags->fl_count++;
        break;
      case 'v':
        selected_flags->v = 1, selected_flags->fl_count++;
        break;
      case 'c':
        selected_flags->c = 1, selected_flags->fl_count++;
        break;
      case 'l':
        selected_flags->l = 1, selected_flags->fl_count++;
        break;
      case 'n':
        selected_flags->n = 1, selected_flags->fl_count++;
        break;
      case 'h':
        selected_flags->h = 1, selected_flags->fl_count++;
        break;
      case 's':
        selected_flags->s = 1, selected_flags->fl_count++;
        break;
      case 'f':
        selected_flags->f = 1, selected_flags->fl_count++;
        flag_f(selected_flags);
        break;
      case 'o':
        selected_flags->o = 1, selected_flags->fl_count++;
        break;
      case '?':
        mark = 1;
        break;
    }
  }
  return mark;
}

void open(int argc, char *argv[], Flags *selected_flags, int how_many) {
  regex_t regex;
  regmatch_t regmatch;
  if (selected_flags->i) {
    regcomp(&regex, selected_flags->templates, REG_EXTENDED | REG_ICASE);
  } else {
    regcomp(&regex, selected_flags->templates, REG_EXTENDED);
  }
  for (; optind < argc; optind++) {
    FILE *file = fopen(argv[optind], "r");
    if (file == NULL) {
      if (!selected_flags->s && !selected_flags->f) {
        fclose(file);
        fprintf(stderr, "simple_grep: %s: No such file or directory\n",
                argv[optind]);
      }
    } else {
      cycle(argv, selected_flags, file, regex, regmatch, how_many);
    }
  }
  regfree(&regex);
}

void cycle(char *argv[], Flags *selected_flags, FILE *file, regex_t regex,
           regmatch_t regmatch, int how_many) {
  char *line = NULL;
  size_t len = 0;
  ssize_t s;
  int found = 0, count = 0, string = 0;
  priority(selected_flags);
  while ((s = getline(&line, &len, file)) != -1 && !found) {
    string++;
    int match = regexec(&regex, line, 1, &regmatch, 0);
    if ((!match && !selected_flags->v) || (match && selected_flags->v)) {
      count++;
      if ((!selected_flags->e && !selected_flags->i && !selected_flags->v &&
           !selected_flags->c && !selected_flags->l && !selected_flags->n &&
           !selected_flags->h && !selected_flags->s && !selected_flags->f &&
           !selected_flags->o) ||
          selected_flags->e || selected_flags->i || selected_flags->f ||
          selected_flags->v) {
        grep(argv, selected_flags, line, how_many);
      }
      if (selected_flags->l && !selected_flags->c) {
        found = flag_l(argv, line);
      }
      if (selected_flags->n) {
        flag_n(argv, selected_flags, line, string, how_many);
      }
      if (selected_flags->h) {
        flag_h(selected_flags, line);
      }
      if (selected_flags->o) {
        flag_o(argv, selected_flags, regex, regmatch, line, string, how_many);
      }
    }
  }
  if (selected_flags->c) {
    flag_c(argv, selected_flags, line, how_many, count);
  }
  fclose(file);
  if (line != NULL) {
    free(line);
    line = NULL;
  }
}

void empty_template(char *argv[], Flags *selected_flags) {
  strcat(selected_flags->templates, argv[optind]);
  selected_flags->t_count++;
  optind++;
}

int how_many_calc(int argc, Flags *selected_flags) {
  int how_many = 0;
  int counter = selected_flags->fl_count + selected_flags->t_count;
  if (selected_flags->f && !selected_flags->e) {
    how_many = argc + selected_flags->t_count - counter - 1;
  } else if (selected_flags->f && selected_flags->e) {
    how_many = argc + selected_flags->t_count - counter - 2;
  } else {
    how_many = argc - counter;
  }
  return how_many;
}

void priority(Flags *selected_flags) {
  if (selected_flags->c || selected_flags->l || selected_flags->n ||
      selected_flags->h || selected_flags->o) {
    selected_flags->e = 0;
    selected_flags->i = 0;
  }
  if (selected_flags->c || selected_flags->l) {
    selected_flags->n = 0;
    selected_flags->o = 0;
  }
  if (selected_flags->v) {
    selected_flags->o = 0;
  }
}

void grep(char *argv[], Flags *selected_flags, char *line, int how_many) {
  if (!selected_flags->c && !selected_flags->l && !selected_flags->n &&
      !selected_flags->h && !selected_flags->o) {
    if (line[strlen(line) - 1] == '\n') {
      line[strlen(line) - 1] = '\0';
    }
    if (how_many > 2) {
      printf("%s:%s\n", argv[optind], line);
    } else {
      printf("%s\n", line);
    }
  }
}

void flag_e(Flags *selected_flags) {
  if (selected_flags->t_count > 0) {
    strcat(selected_flags->templates, "|");
  }
  selected_flags->t_count++;
  strcat(selected_flags->templates, optarg);
}

void flag_c(char *argv[], Flags *selected_flags, char *line, int how_many,
            int count) {
  if (line[strlen(line) - 1] == '\n') {
    line[strlen(line) - 1] = '\0';
  }
  if (selected_flags->h || how_many <= 2) {
    if (selected_flags->l && count > 0) {
      printf("1\n");
      flag_l(argv, line);
    } else {
      printf("%d\n", count);
    }
  } else {
    if (selected_flags->l && count > 0) {
      printf("%s:1\n", argv[optind]);
      flag_l(argv, line);
    } else {
      printf("%s:%d\n", argv[optind], count);
    }
  }
}

int flag_l(char *argv[], char *line) {
  int found = 1;
  if (line[strlen(line) - 1] == '\n') {
    line[strlen(line) - 1] = '\0';
  }
  printf("%s\n", argv[optind]);
  return found;
}

void flag_n(char *argv[], Flags *selected_flags, char *line, int string,
            int how_many) {
  if (!selected_flags->o) {
    if (line[strlen(line) - 1] == '\n') {
      line[strlen(line) - 1] = '\0';
    }
    if (selected_flags->h || how_many <= 2) {
      printf("%d:%s\n", string, line);
    } else {
      printf("%s:%d:%s\n", argv[optind], string, line);
    }
  }
}

void flag_h(Flags *selected_flags, char *line) {
  if (!selected_flags->c && !selected_flags->n && !selected_flags->o &&
      !selected_flags->l) {
    if (line[strlen(line) - 1] == '\n') {
      line[strlen(line) - 1] = '\0';
    }
    printf("%s\n", line);
  }
}

void flag_f(Flags *selected_flags) {
  FILE *file = fopen(optarg, "r");
  if (file == NULL) {
    fclose(file);
    fprintf(stderr, "simple_grep: %s: No such file or directory\n", optarg);
  } else {
    char line[N];
    while (fgets(line, N, file) != NULL) {
      if (line[strlen(line) - 1] == '\n') {
        line[strlen(line) - 1] = '\0';
      }
      if (selected_flags->t_count > 0) {
        strcat(selected_flags->templates, "|");
      }
      selected_flags->t_count++;
      strcat(selected_flags->templates, line);
    }
    fclose(file);
  }
}

void flag_o(char *argv[], Flags *selected_flags, regex_t regex,
            regmatch_t regmatch, char *line, int string, int how_many) {
  char *start = line;
  while ((regexec(&regex, start, 1, &regmatch, 0)) == 0) {
    if (selected_flags->n) {
      if (selected_flags->h || how_many <= 2) {
        printf("%d:%.*s\n", string, (int)(regmatch.rm_eo - regmatch.rm_so),
               start + regmatch.rm_so);
      } else {
        printf("%s:%d:%.*s\n", argv[optind], string,
               (int)(regmatch.rm_eo - regmatch.rm_so), start + regmatch.rm_so);
      }
    } else if (selected_flags->h || how_many <= 2) {
      printf("%.*s\n", (int)(regmatch.rm_eo - regmatch.rm_so),
             start + regmatch.rm_so);
    } else {
      printf("%s:%.*s\n", argv[optind], (int)(regmatch.rm_eo - regmatch.rm_so),
             start + regmatch.rm_so);
    }
    start += regmatch.rm_eo;
  }
}