CREATE TABLE observations (
    `id` String,
    `trace_id` String,
    `project_id` String,
    `type` String,
    `parent_observation_id` Nullable(String),
    `start_time` DateTime64(6),
    `end_time` Nullable(DateTime64(6)),
    `name` String,
    metadata Map(String, String) CODEC(ZSTD(1)),
    `level` String,
    `status_message` Nullable(String),
    `version` Nullable(String),
    `input` Nullable(String) CODEC(ZSTD(1)),
    `output` Nullable(String) CODEC(ZSTD(1)),
    `model` Nullable(String),
    `internal_model` Nullable(String),
    `model_parameters` Nullable(String),
    `prompt_tokens` Nullable(Int32),
    `completion_tokens` Nullable(Int32),
    `total_tokens` Nullable(Int32),
    `unit` Nullable(String),
    `input_cost` Nullable(Float64),
    `output_cost` Nullable(Float64),
    `total_cost` Nullable(Float64),
    `completion_start_time` Nullable(DateTime64(6)),
    `prompt_id` Nullable(String),
    created_at DateTime64(6) DEFAULT now(),
    INDEX idx_id id TYPE bloom_filter(0.001) GRANULARITY 1,
    INDEX idx_trace_id trace_id TYPE bloom_filter(0.001) GRANULARITY 1,
    INDEX idx_project_id trace_id TYPE bloom_filter(0.001) GRANULARITY 1,
    INDEX idx_res_metadata_key mapKeys(metadata) TYPE bloom_filter(0.01) GRANULARITY 1,
    INDEX idx_res_metadata_value mapValues(metadata) TYPE bloom_filter(0.01) GRANULARITY 1
) ENGINE = ReplacingMergeTree Partition by toYYYYMM(start_time)
ORDER BY (
        project_id,
        `type`,
        toUnixTimestamp(start_time),
        trace_id,
        id
    );