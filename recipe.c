#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <tree_sitter/api.h>
#include <assert.h>

TSLanguage *tree_sitter_heex();

static const char*
read_buffer (void *buffer, uint32_t byte_index,
		     TSPoint position, uint32_t *bytes_read) {
  if (byte_index < strlen(buffer)) {
	*bytes_read = strlen(buffer) - byte_index;
	return ((char *) buffer) + byte_index;
  }
  *bytes_read = 0;
  return NULL;
}

void log(void *payload, TSLogType log_type, const char *buffer) {
  printf ("%s\n", buffer);
}

int main() {

  TSParser *parser = ts_parser_new();
  ts_parser_set_language(parser, tree_sitter_heex());

  TSLogger logger;
  logger.payload = NULL;
  logger.log = log;

  ts_parser_set_logger(parser, logger);

  FILE *fd = fopen("hang.ex", "r");

  if (fd == NULL) return -1;

  char *source = NULL;
  size_t len;
  ssize_t bytes_read = getdelim(&source, &len, '\0', fd);

  if (bytes_read == -1) return -1;

  /* printf ("%s", source); */

  const TSRange ranges[3] = {
	{{0,0},{0,0},108,240},
	{{0,0},{0,0},300,572},
	{{0,0},{0,0},820,1346}
  };

  bool suc = ts_parser_set_included_ranges(parser, &ranges, 3);
  if (!suc) return -1;

  TSInput input = {(void *) source, read_buffer, TSInputEncodingUTF8};
  TSTree *tree = ts_parser_parse (parser, NULL, input);

  printf("%s\n", ts_node_string (ts_tree_root_node (tree)));

  /* TSTree *tree = ts_parser_parse_string(parser, NULL, source, strlen(source)); */
  return 0;
}
